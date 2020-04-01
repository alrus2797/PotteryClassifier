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
            <div class="home registered">
                <br><br>
                <h1 class="header center blue-text">Thanks, <a class="user-container"></a></h1>
                <div class="row center">
                    <h5 class="header col s12 light">For your collaboration
                    </h5>
                </div>
                <br><br>
            </div>

            <div class="valign-wrapper loader">
                <br><br><br><br><br><br><br><br><br><br>
                <div class="progress">
                    <div class="indeterminate"></div>
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
            
        });


        $('.sign-out').click(function () {
            firebase.auth().signOut().then(function () {
                window.location.href='/'
            }).catch(function (error) {
                console.log(error);
                alert('Error:', error);
            });
        });
    </script>
</body>

</html>