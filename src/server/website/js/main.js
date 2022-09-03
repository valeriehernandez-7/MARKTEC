// listado inicial
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
  var url = "http://localhost:8000/itemsCatFilter"
  const $select = $("#cat")
  fetch(url, options).then(response => response.json())
  .then(response => {
    console.log(response);

    for (var i = 0; i < response.length; i++) {
      valor=response[i].Name;
      $select.append($("<option>", {
        value: valor,
        text: valor
      }));
    }

}).catch(e => {
    console.log(e);
});
})

// botón filtro categoria
function catfil() {
  var category = $("#cat").val();
  $("#cat").val("");
  $("#cant").val('');
  $("#desc").val('');
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
  // petición HTTP
  fetch(url, options).then(response => response.json())
  .then(response => {
    console.log(response);
    $("#tablaItems").empty();
    style="text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;"
    $("#tablaItems ").append("<tr><th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">ID</th>"+
                                  "<th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">DESCRIPCIÓN</th>"+
                                  "<th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">CATEGORÍA</th>"+
                                  "<th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">PRECIO</th></tr>");
    for (var i = 0; i < response.length; i++) {
      $("#tablaItems ").append("<tr><td>"+response[i].ID +"</td><td>"+response[i].Description +"</td><td>"+response[i].Category +"</td><td>"+response[i].Price +"</td></tr>");
    }
}).catch(e => {
    console.log(e);
});
}

function descfil() {
  var itemDescription = $("#desc").val();
  $("#cat").val("");
  $("#cant").val('');
  $("#desc").val('');
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
    $("#tablaItems ").append("<tr><th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">ID</th>"+
                                  "<th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">DESCRIPCIÓN</th>"+
                                  "<th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">CATEGORÍA</th>"+
                                  "<th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">PRECIO</th></tr>");
    for (var i = 0; i < response.length; i++) {
      $("#tablaItems").append("<tr><td>"+response[i].ID +"</td><td>"+response[i].Description +"</td><td>"+response[i].Category +"</td><td>"+response[i].Price +"</td></tr>");
    }
}).catch(e => {
    console.log(e);
});
}

function cant() {
  var itemAmount = $("#cant").val();
  $("#cat").val("");
  $("#cant").val('');
  $("#desc").val('');
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
    $("#tablaItems ").append("<tr><th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">ID</th>"+
                                  "<th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">DESCRIPCIÓN</th>"+
                                  "<th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">CATEGORÍA</th>"+
                                  "<th style=\"text-align:center; color: #FFFFFF; background-color: #017bab; border: 2px solid #017bab;\">PRECIO</th></tr>");
    for (var i = 0; i < response.length; i++) {
      $("#tablaItems").append("<tr><td>"+response[i].ID +"</td><td>"+response[i].Description +"</td><td>"+response[i].Category +"</td><td>"+response[i].Price +"</td></tr>");
    }
}).catch(e => {
    console.log(e);
});
}

function add() {
  var user = (new URL(location.href)).searchParams.get('user')
  location.replace(' ./insertItem.html?user='+user);
}

function cerrar() {
  location.replace(' ./index.html');
}
