
//funcion que añade las caracteristicas para poder seleccionarlas
$(document).ready(function(){
    const $select = $("#categorias")
    var url = "http://localhost:8000/itemsCatFilter"
    const options = {
    method: "get",
    headers: {"Content-Type": "application/json"},
    };
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

//funcion para agregar el articulo
async function add() {
  try {
    const response = await axios.get('https://api.ipify.org?format=json');
    var url = "http://localhost:8000/itemsInsert"
    var category = $("#categorias").val()
    var price = $("#price").val();
    var desc = $("#descrip").val();
    const body={
        category: category,
        description: desc,
        price:price,
        ip: response.data.ip,
    }
    if(category=="Categoria" || price=="" || desc == ""){
        window.alert("Debe rellenar todos los campos");
        return
    }
    const options = {
    method: "post",
    body: JSON.stringify(body),
    headers: {"Content-Type": "application/json"},
    };
    // Petición HTTP
    fetch(url, options).then(response => response.json())
    .then(response => {
      console.log(response);
      if(response == 5406){
        window.alert("Este item ya existe");
        return
      }
      if(response == 5200){
        window.alert("Item ingresado con exito");
        return
      }else {
          window.alert("Ocurrio un error al ingresar el dato");
      }



      }
    ).catch(e => {
      console.log(e);
  });
  } catch (error) {
    console.error(error);
  }
}






//funcion para volver a la pagina principal
function ret() {
  location.replace('file:///D:/Tec/S%202%202022/bases/t1/MARKTEC/src/pagina/principal.html');
}
