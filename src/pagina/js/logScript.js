//const Url = 'http://localhost:8000/login'
//const data={
//  "username":"JVasquez",
//  "password": "Bi30G2"
//}
//$('.buttons').click(function functionName() {
//    $.get(Url,function(data,status){
//      console.log( '${data}')
//    })
//})







function validateEmailAddress() {
var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
return re.test(email);
}


function login() {
  var user = $("#usuario").val();
  var pass = $("#contrasena").val();
  console.log(user,pass)
  var url = "http://localhost:8000/login?"+ new URLSearchParams({
    usuario:user,
    pass:pass,
  })
  //const Url = 'http://localhost:8000/login'
  var datos={
    "username":"JVasquez",
    password: "Bi30G2"
  }

  const options = {
  method: "get",
  //mode: 'no-cors',
  headers: {"Content-Type": "application/json"},

  };
  // Petición HTTP
  console.log(JSON.stringify(datos));
  fetch(url, options).then(response => response.json())
.then(response => {

    console.log(response )

}).catch(e => {
    console.log(e);
});

}
$("#logBtn").bind("click", login);
