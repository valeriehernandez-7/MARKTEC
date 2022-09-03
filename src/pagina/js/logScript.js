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
      if (response == 5200){
          location.replace('file:///D:/Tec/S%202%202022/bases/t1/MARKTEC/src/pagina/principal.html?user='+user);
      }else{
        window.alert("Usuario o contraseña invalidos");
        return
      }
}).catch(e => {
    console.log(e);
});

}
$("#logBtn").bind("click", login);
