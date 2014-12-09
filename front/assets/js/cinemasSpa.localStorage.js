var storage_cinemas = (function(){
	
	_add = function (id, name, street, latitude, longitude){

		var film_list = (JSON.parse(_get(id)) || []);


		if (id === "Cinemas") {
			film_list.push({"name":name, 
								 "street":street, 
								 "latitude":latitude, 
								 "longitude":longitude});
		}
		else 
			film_list = [{"name":name}];

		film_list = JSON.stringify(film_list);

		window.localStorage.setItem(id, film_list);

	};

	_get = function(id){
		return window.localStorage.getItem(id);
	};

	_show = function(id){
		film = _get(id);
		film_json = JSON.parse(film);
		console.log(film_json);
	};

	_search = function(id,criteria,value){

		film_list = _get(id);
		array_film_list = JSON.parse(film_list);
		found = [];
		for (i=0, len = array_film_list.length; i<len; i++)
		{
			if(array_film_list[i][criteria] === value)
				found.push(array_film_list[i]);
		}

		return found;

	};

	_delete = function(id, criteria, value){


		if ( ( (film_list = _get(id)) !== null ) && ( ( array_film_list = JSON.parse(film_list) ).length !== 0  ) )
		{
			array_film_list_after_delete = _delete_films_by(criteria, value, "erase")
			window.localStorage.setItem(id, JSON.stringify(array_film_list_after_delete));
		}

	};

	_delete_films_by = function(criteria, value, task){
		
		coincidences = [];
		differences = [];
		result = [];

		for (i=0, len = array_film_list.length; i<len; i++) {
			film = array_film_list[i];
			(film[criteria] === value) ? coincidences.push(film) : differences.push(film);
			(task === "erase") ? result = differences : result = coincidences;
		}
		return result;
	};


	return{
		version :"1.0.0",
		add : _add,
		get : _get,
		show : _show,
		search : _search,
		delete : _delete
	}

})();