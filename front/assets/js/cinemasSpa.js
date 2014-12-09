window.cinemasSpa = {};


window.cinemasSpa.C = {
   FIELDS : ["name", "street", "latitude", "longitude"],
   QUERY: {
      LIST_ITEM     : "li[data-name]"
   },
   EVENT: {
      CLICK        : "click"
  }
};

// -- INIT ---------------------------------------------------------------------
window.C = cinemasSpa.C;



//ironhack.addMyEvent(document.getElementById("add_cinema_btn"), "click", callback);

document.getElementById("add_cinema_btn").addEventListener("click",function(event){
  event.preventDefault();
  event.stopPropagation();

  obj_cinemas = {};
  for (var i = 0, len = C.FIELDS.length; i < len; i++) {
   field = C.FIELDS[i];
   obj_cinemas[field] = document.querySelector("input[name=" + field + "]").value;
  }
  storage_cinemas.add("Cinemas",
                     obj_cinemas.name,
                     obj_cinemas.street, 
                     obj_cinemas.latitude, 
                     obj_cinemas.longitude);
  
  add_cinema_to_list(obj_cinemas.name, obj_cinemas.street);
});

function add_cinema_to_list(name, street)
{
  
  var ul = document.getElementById("cinema_list");
  var li = document.createElement("li");
  var strong = document.createElement("span");
  //var span = document.createElement("strong");
  var small = document.createElement("small");

  li.setAttribute("data-name", "");

  strong.appendChild(document.createTextNode(name));
  small.appendChild(document.createTextNode(street));
  //span.appendChild(document.createTextNode("hi"));

  //li.appendChild(span);
  li.appendChild(strong);
  li.appendChild(small);
  ul.appendChild(li);
}

function check_session()
{
  
  user_session = storage_cinemas.get("Session");

  if(user_session === null)
  {
    var user_name ="";
    while(user_name === null ||user_name.length<=0 )
    {
      user_name = prompt();

    }
    storage_cinemas.add("Session", user_name);
    document.getElementById("session").innerHTML  = user_name;
    user_session = storage_cinemas.get("Session");
  }
  else
  {
    user_session = storage_cinemas.get("Session");
  }

  document.getElementById("session").innerHTML  = JSON.parse(user_session)[0].name;    
  cinemas_session = storage_cinemas.get("Cinemas");
  if(cinemas_session !==null)
  {
    cinema_list = JSON.parse(cinemas_session);
    for(var i=0, len=cinema_list.length;i<len;i++)
    {
      c = cinema_list[i];
      add_cinema_to_list(c.name, c.street);
    }
  }

}



document.getElementsByTagName("li")[0].addEventListener("click",function(event){
  event.preventDefault();
  event.stopPropagation();

  cinema_name = document.getElementsByTagName("li:target > strong").value;

  cinema_target_array = storage_cinemas.search("Cinemas", "name", cinema_name);

  cinema_target = cinema_target_array[0];

  push_pins_marker(cinema_target.latitude, cinema_target.longitude);

  
  var fields = ["name_cinema","street_cinema", "latitude_cinema", "longitude_cinema"];
  obj_cinemas = {};
  for (var i = 0, len = fields.length; i < len; i++) {
    obj_cinemas[fields[i]] = document.querySelector("input[name=" + fields[i] + "]").value;
  }
  storage_cinemas.add("Cinemas",obj_cinemas.name_cinema,obj_cinemas.street_cinema, obj_cinemas.latitude_cinema, obj_cinemas.longitude_cinema);
  
  add_cinema_to_list(obj_cinemas.name_cinema, obj_cinemas.street_cinema);
});



$(C.QUERY.LIST_ITEM).on(C.EVENT.CLICK, function(event) {
   console.log("siblings");
   var el = $(event.delegateTarget);
   el.addClass("active").siblings().removeClass("active");
   var cinema = storage.select(C.STORAGE.CINEMAS, "name", el.attr("data-name"));
   console.log(cinema[0]);
   // @TODO: Show in map
});