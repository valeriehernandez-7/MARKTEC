//;ista inicial
$(document).ready(function(){
    var url = "http://localhost:8000/itemsCategory"
    const options = {
    method: "get",
    headers: {"Content-Type": "application/json"},
    };
    fetch(url, options).then(response => response.json())
    .then(response => {
      $("#tableBody > tbody").empty();
      for (var i = 0; i < response.length; i++) {
        $("#tablaItems ").append("<tr><td> "+response[i].ID +"</td><td>"+response[i].Description +" </td><td> "+response[i].Category +" </td><td> "+response[i].Price +" </td></tr>");
      }

  }).catch(e => {
      console.log(e);
  });
})
//boton filto categoria
function catfil() {
  var category = $("#cat").val();
  var url = "http://localhost:8000/itemsCategory?"
  if (category != ""){
      url= url+new URLSearchParams({
        itemCategoryName:category,
      })
  }
  if(category.includes(";") ){
    window.alert("No debe incluir ;");
    return;
  }
  const options = {
  method: "get",
  headers: {"Content-Type": "application/json"},
  };
  // Petición HTTP
  fetch(url, options).then(response => response.json())
  .then(response => {
    console.log(response);
    $("#tablaItems").empty();
    $("#tablaItems ").append("<tr><th>ID</th><th>Descripcion</th><th> Categoria</th><th>Precio</th></tr>");
    for (var i = 0; i < response.length; i++) {
      $("#tablaItems ").append("<tr><td>"+response[i].ID +"</td><td>"+response[i].Description +"</td><td>"+response[i].Category +"</td><td>"+response[i].Price +"</td></tr>");
    }
}).catch(e => {
    console.log(e);
});
}
function descfil() {
  var itemDescription = $("#desc").val();
  var url = "http://localhost:8000/itemsDescription?"
  if (itemDescription != ""){
      url= url+new URLSearchParams({
        itemDescription:itemDescription,
      })
  }
  if(itemDescription.includes(";") ){
    window.alert("No debe incluir ;");
    return;
  }
  const options = {
  method: "get",
  headers: {"Content-Type": "application/json"},
  };
  // Petición HTTP
  fetch(url, options).then(response => response.json())
  .then(response => {
    console.log(response);
    $("#tablaItems ").empty();
    $("#tablaItems").append("<tr><th>ID</th><th>Descripcion</th><th> Categoria</th><th>Precio</th></tr>");
    for (var i = 0; i < response.length; i++) {
      $("#tablaItems").append("<tr><td>"+response[i].ID +"</td><td>"+response[i].Description +"</td><td>"+response[i].Category +"</td><td>"+response[i].Price +"</td></tr>");
    }
}).catch(e => {
    console.log(e);
});
}

function cant() {
  var itemAmount = $("#cant").val();
  var url = "http://localhost:8000/itemsAmount?"
  if (itemAmount != ""){
      url= url+new URLSearchParams({
        itemAmount:itemAmount,
      })
  }
  const options = {
  method: "get",
  headers: {"Content-Type": "application/json"},
  };
  // Petición HTTP
  fetch(url, options).then(response => response.json())
  .then(response => {
    console.log(response);
    $("#tablaItems ").empty();
    $("#tablaItems").append("<tr><th>ID</th><th>Descripcion</th><th> Categoria</th><th>Precio</th></tr>");
    for (var i = 0; i < response.length; i++) {
      $("#tablaItems").append("<tr><td>"+response[i].ID +"</td><td>"+response[i].Description +"</td><td>"+response[i].Category +"</td><td>"+response[i].Price +"</td></tr>");
    }
}).catch(e => {
    console.log(e);
});
}

function add() {
  var user = (new URL(location.href)).searchParams.get('user')
  location.replace('file:///D:/Tec/S%202%202022/bases/t1/MARKTEC/src/pagina/insertItem.html?user='+user);
}
function cerrar() {
  location.replace('file:///D:/Tec/S%202%202022/bases/t1/MARKTEC/src/pagina/index.html');
}
