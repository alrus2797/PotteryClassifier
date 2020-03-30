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
                <li><a href="#" class="registered">Cerrar Sesión</a></li>
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
                <br>
                <div class="col s12 m7">
                    <div class="card horizontal">
                        <div class="card-image">
                            <img id="pottery-img" src="src/images/a.jpg">
                        </div>
                        <div class="card-stacked">
                            <div class="card-content">
                                <h4>Clases</h4>
                                <p>I am a very simple card. I am good at containing small bits of information.</p>
                            </div>
                            <div class="card-action ">
                                <a href="#" id="previous" class="left blue-text">Anterior</a>
                                <a href="#" id="next" class="right blue-text">Siguiente</a>
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
    <script src="https://www.gstatic.com/firebasejs/7.13.1/firebase-analytics.js"></script>

    <script>

        //Materialize inizializations
        $(document).ready(function () {
            $('.sidenav').sidenav();
            $('.registered').hide();
            $('.guest').hide();
        });




        // Your web app's Firebase configuration
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

        firebase.auth().onAuthStateChanged(function (user) {
            if (user) {
                $('.user-container').text(user.displayName);
                $('.registered').show();
                $('.guest').hide();
            } else {
                $('.registered').hide();
                $('.guest').show();
            }
            $('.loader').hide();
        });

        // console.log("Name:", firebase.app(), firebase.app().name);

        var provider = new firebase.auth.GoogleAuthProvider();

        function register() {
            firebase.auth().signInWithPopup(provider).then(function (result) {
                // This gives you a Google Access Token. You can use it to access the Google API.
                var token = result.credential.accessToken;
                // The signed-in user info.
                var user = result.user;
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
        })

    </script>
</body>

</html>