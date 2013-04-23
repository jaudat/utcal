function maxDays(year, month){
        return new Date(year, month, 0).getDate();
}

function convertDateToJS(input){
        var dateValues = input.split("-");
        return new Date(Number(dateValues[0]), Number(dateValues[1])-1, Number(dateValues[2]));
}

function buildCalendar(coursesToJSON, assignmentsToJSON){
        
	var dateSet = new Array();
        var i = 0;

	var jointArray = coursesToJSON.concat(assignmentsToJSON);

        for ( i = 0; i < jointArray.length; i++){
                var dateObject = new Array();

                dateObject["start"]= new Date(jointArray[i].start*1000);
                dateObject["end"] = new Date(jointArray[i].end*1000);

		if(i < coursesToJSON.length){
			dateObject["type"] = "course";
		}else{
			dateObject["type"] = "event";
		}

		dateObject["title"] = jointArray[i].title;


                if(dateObject["start"].getMonth() == 0){
                        var endBefore = new Date(dateObject["start"].getFullYear(), 3, 8);
                }else if(dateObject["start"].getMonth() == 3){
                        var endBefore = new Date(dateObject["start"].getFullYear(), 7, 8);
                }else{
                        var endBefore = new Date(dateObject["start"].getFullYear(), 11, 6);
                }
		if(dateObject["type"] == "course"){
                	while(dateObject["start"].getTime() < endBefore.getTime()){

                        	var polishToAdd = new Array();
                        	polishToAdd["start"] = dateObject['start'].getTime()/1000;
                       		polishToAdd["end"] = dateObject["end"].getTime()/1000;
                        	polishToAdd["start"] += 18000;
                        	polishToAdd["end"] += 18000;
                       	 	polishToAdd["title"] = dateObject["title"];
                        	polishToAdd["allDay"] = false;
                        	dateSet.push(polishToAdd);

                        	dateObject["start"].setMinutes(dateObject["start"].getMinutes() + 60*24*7);
                        	dateObject["end"].setMinutes(dateObject["end"].getMinutes() + 60*24*7);
                	}
		}else{
			var toAdd = new Array();
			toAdd["start"] = dateObject['start'].getTime()/1000;
			toAdd["end"] = dateObject['end'].getTime()/1000;
			toAdd["start"] += 18000;
			toAdd["end"] += 18000;
			toAdd["title"] = dateObject["title"];
			toAdd["allDay"] = false;
			dateSet.push(toAdd);
		}
        }

        $("#calendar").fullCalendar({
                header: {
                        left: 'prev, next today',
                        middle: dateObject["start"].getFullYear().toString() ,
                        right: 'agendaWeek'
                },
                events: dateSet,
                defaultView: 'agendaWeek',
                editable: false,
                slotMinutes: 60,
                minTime: 9,
                maxTime: 23
        });	
}
