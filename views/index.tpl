<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pottery Clasifier</title>

    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="src/css/materialize.min.css" media="screen,projection" />

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        .valign-wrapper {
            flex-wrap: wrap;
        }
    </style>
</head>

<body>


    <nav class="light-green " role="navigation">
        <div class="nav-wrapper container"><a id="logo-container" href="#" class="brand-logo">Pottery Classifier</a>
            <ul class="right hide-on-med-and-down">
                <li><a href="#" id="user" class="user-container registered"></a></li>
                <li><a href="#" class="registered sign-out">Cerrar Sesión</a></li>
            </ul>

            <ul id="nav-mobile" class="sidenav">
                <div class="row"></div>
                <li><a href="#" class="user-container registered"></a></li>
                <li><a href="#" class="registered sign-out">Cerrar Sesión</a></li>
            </ul>
            <a href="#" data-target="nav-mobile" class="sidenav-trigger"><i class="material-icons">menu</i></a>
        </div>
    </nav>



    <div class="section no-pad-bot" id="index-banner">
        <div class="container">
            <div class="home guest">
                <br><br>
                <h1 class="header center blue-text">Starter Template</h1>
                <div class="row center">
                    <h5 class="header col s12 light">A modern responsive front-end framework based on Material Design
                    </h5>
                </div>
                <div class="row center">
                    <a href="#" id="register" class="btn-large waves-effect waves-light blue darken-2">Registrar para
                        iniciar</a>
                </div>
                <br><br>
            </div>
            <div class="valign-wrapper loader">
                <br><br><br><br><br><br><br><br><br><br>
                <div class="progress">
                    <div class="indeterminate"></div>
                </div>
            </div>

            <div class="registered">
                <h2 class="center blue-text">Classifier</h2>
                <h5 id="n-potteries" class="center"></h5>
                <br>
                <div class="row valign-wrapper">
                    <div class="col s12 m6">
                        <img class="responsive-img" id="pottery-img" src="" data-id="">
                    </div>
                    <div class="col s12 m6">
                        <div class="card">
                            <div class="card-content center">
                                <h4>Classes</h4>
                                <form action="">
                                    %for _class in classes:
                                    <p>
                                        <label>
                                            <input class="pottery-class" name="pottery_class" type="radio"
                                                value="{{_class}}" />
                                            <span>{{_class.title()}}</span>
                                        </label>
                                    </p>
                                    <br>
                                    %end
                                </form>
                                <div class="card-action ">
                                    <a href="#" id="next" class="right waves-effect blue darken-2 btn-small disabled"><i
                                            class="material-icons right">send</i>Next</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>








    <!--JS Stuff-->
    <script type="text/javascript" src="src/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="src/js/materialize.min.js"></script>
    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/7.13.1/firebase-app.js"></script>

    <!-- TODO: Add SDKs for Firebase products that you want to use
        https://firebase.google.com/docs/web/setup#available-libraries -->
    <script src="https://www.gstatic.com/firebasejs/7.13.1/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.13.1/firebase-database.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.13.1/firebase-analytics.js"></script>

    <script>

        var firebaseConfig = {
            apiKey: "AIzaSyC3ccOEGIYadjSd84rfckUEKNYYlYuSgbQ",
            authDomain: "potteryclassifier.firebaseapp.com",
            databaseURL: "https://potteryclassifier.firebaseio.com",
            projectId: "potteryclassifier",
            storageBucket: "potteryclassifier.appspot.com",
            messagingSenderId: "1014888647163",
            appId: "1:1014888647163:web:b7af6b584784b2ccb0635e",
            measurementId: "G-DZFQQESV2T"
        };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
        firebase.analytics();
        firebase.auth().setPersistence(firebase.auth.Auth.Persistence.SESSION);



        // console.log("Name:", firebase.app(), firebase.app().name);

        var provider = new firebase.auth.GoogleAuthProvider();
        var database = firebase.database();

        var n_potteries;

        $(document).ready(function () {
            //Materialize inizializations
            $('.sidenav').sidenav();
            $('.registered').hide();
            $('.loader').show();
            $('.guest').hide();


            // Your web app's Firebase configuration

            firebase.auth().onAuthStateChanged(function (user) {
                if (user) {
                    $('.user-container').text(user.displayName);
                    $('.registered').show();
                    $('.guest').hide();

                    //Start with images request
                    console.log(user.uid);
                    var pick;
                    database.ref('/properties').once('value').then(function (snapshot) {
                        n_potteries = snapshot.val().n_potteries;
                    }).then(function(){
                        database.ref('/users/' + user.uid).once('value').then(function (snapshot) {
                            pick = snapshot.val().next_pick;
                            if (pick >= n_potteries){
                                alert('You\'re done with pots.');
                                window.location.replace('thanks')
                                return;
                            }
                            $('#pottery-img').attr('src', '/images/' + pick + '.png');
                            $('#pottery-img').data('id', pick);
                        }).then(function(){
                            $('#n-potteries').text('Pot ' + (pick + 1) + '/' + (n_potteries));
                        });
                    });

                } else {
                    $('.registered').hide();
                    $('.guest').show();
                }
                $('.loader').hide();
            });


        });







        function register() {
            firebase.auth().signInWithPopup(provider).then(function (result) {
                // This gives you a Google Access Token. You can use it to access the Google API.
                var token = result.credential.accessToken;
                // The signed-in user info.
                var user = result.user;
                database.ref('users/' + user.uid).set({
                    "next_pick": 0
                })
            }).catch(function (error) {
                // Handle Errors here.
                var errorCode = error.code;
                var errorMessage = error.message;
                // The email of the user's account used.
                var email = error.email;
                // The firebase.auth.AuthCredential type that was used.
                var credential = error.credential;
                // ...
            });
        }


        //Funcionality

        $('#register').click(function () {
            register();
        });


        $('.sign-out').click(function () {
            firebase.auth().signOut().then(function () {
                $('.registered').hide();
                $('.guest').show();
            }).catch(function (error) {
                console.log(error);
                alert('Error:', error);
            });
        });

        $('.pottery-class').click(function(){
            $('#next').removeClass('disabled');
        });

        $('#next').click(function () {
            var checked = $('.pottery-class:checked').val();
            if (checked == null){
                alert("Select a class first");
                return;
            }
            var user = firebase.auth().currentUser
            var pottery_id = $('#pottery-img').data('id');
            if (user && pottery_id != null){
                var error_flag = false;
                console.log("Class:", checked, "By", user.displayName, "Pot_id: ", pottery_id);
                database.ref('/scores/'+pottery_id+'/'+checked).transaction(function(currentScore){
                    return currentScore + 1;
                }, function(error){
                    if (error){
                        console.log("Error: ", error);
                        alert("An error ocurred (see console for more information)"); 
                        error_flag = true;
                    }
                    else{
                        console.log('Okey');
                    }
                }).then(function(){
                    if (error_flag == true){
                        return;
                    }
                    database.ref('/users/'+user.uid).update({
                        'next_pick': pottery_id + 1
                    }, function(error){
                        if (error){
                            console.log("Error: ", error);
                            alert("An error ocurred (see console for more information)");
                        }
                        else{
                            $('#pottery-img').data('id', pottery_id + 1);
                            if (pottery_id + 1 >= n_potteries){
                                alert('This is the last pot. Thanks for your collaboration');
                                window.location.replace('thanks')
                                return;
                            }
                            $('#pottery-img').attr('src', '/images/' + (pottery_id + 1) + '.png');
                            $('#n-potteries').text('Pot ' + (pottery_id + 2) + '/' + (n_potteries));
                        }
                    });
                });



            }
        })

    </script>
</body>

</html>