function login() {
  var user = $("#usuario").val();
  var pass = $("#contrasena").val();
  if (user == "" || pass==""){
      window.alert("Debe ingresar un usuario y contraseña");
      return;
  }
  if(user.includes(";") || pass.includes(";")){
    window.alert("No debe incluir ; en el usuario o la conreaseña");
    return;
  }
  var url = "http://localhost:8000/login?"+ new URLSearchParams({
    usuario:user,
    pass:pass,
  })
  //const Url = 'http://localhost:8000/login'
  var datos={
    "username":user,
    password: pass,
  }

  const options = {
  method: "get",
  headers: {"Content-Type": "application/json"},
  };

  // Petición HTTP
  fetch(url, options).then(response => response.json())
.then(response => {
  if (response == 5401){
      window.alert("Usuario o contraseña invalidos");
  }
  //console.log(response )
  //window.alert(response);

}).catch(e => {
    console.log(e);
});

}
$("#logBtn").bind("click", login);
