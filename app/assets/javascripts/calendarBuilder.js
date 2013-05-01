var mouseX, mouseY;
$(document).ready(function(){
	$(this).mousemove(function(e){
		mouseX = e.pageX;
		mouseY = e.pageY;
	});	
});

function maxDays(year, month){
        return new Date(year, month, 0).getDate();
}

function convertDateToJS(input){
        var dateValues = input.split("-");
        return new Date(Number(dateValues[0]), Number(dateValues[1])-1, Number(dateValues[2]));
}

function trim(text) {
    return text.replace(/^\s+|\s+$/g, "");
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
                }else if(dateObject["start"].getMonth() == 4){
                        var endBefore = new Date(dateObject["start"].getFullYear(), 6, 30);
                }else{
                        var endBefore = new Date(dateObject["start"].getFullYear(), 11, 6);
                }
		if(dateObject["type"] == "course"){
                	while(dateObject["start"].getTime() < endBefore.getTime()){

                        	var polishToAdd = new Array();
                        	polishToAdd["start"] = dateObject['start'].getTime()/1000;
                       		polishToAdd["end"] = dateObject["end"].getTime()/1000;
                        	polishToAdd["start"] += 14400;
                        	polishToAdd["end"] += 14400;
                       	 	polishToAdd["title"] = dateObject["title"].split("#")[0];
                        	polishToAdd["allDay"] = false;
                        	dateSet.push(polishToAdd);

                        	dateObject["start"].setMinutes(dateObject["start"].getMinutes() + 60*24*7);
                        	dateObject["end"].setMinutes(dateObject["end"].getMinutes() + 60*24*7);
                	}
		}else{
			var toAdd = new Array();
			toAdd["start"] = dateObject['start'].getTime()/1000;
			toAdd["end"] = dateObject['end'].getTime()/1000;
			toAdd["start"] += 14400;
			toAdd["end"] += 14400;
			toAdd["title"] = dateObject["title"].split("(")[0];
			toAdd["allDay"] = false;
			dateSet.push(toAdd);
		}
        }

        $("#calendar").fullCalendar({
                header: {
                        left: 'prev, next today',
                        center: "title" ,
                        right: 'agendaWeek'
                },
                events: dateSet,
                defaultView: 'agendaWeek',
                editable: false,
                slotMinutes: 30,
                minTime: 9,
                maxTime: 23
        });	

}

function setHover(assignmentsToJSON, coursesToJSON){
        $(".fc-event-title").hover(function(e){
		var i;
                for(i = 0; i < assignmentsToJSON.length; i++){
                        if(assignmentsToJSON[i].title.split("(")[0] == $(e.target).text()){
                                var currAssign = assignmentsToJSON[i];
                        }
                }
		if(currAssign===undefined){
			for(i = 0; i < coursesToJSON.length; i++){
				if(coursesToJSON[i].title.split("#")[0] = $(e.target).text()){
					var currCourse = coursesToJSON[i];
				}
			}
		}

                $("body").prepend("<div class='testClass'></div>");
                $(".testClass").css("position","absolute");
                $(".testClass").css("margin-left", mouseX);
                $(".testClass").css("margin-top", mouseY-40);
                $(".testClass").css("width", "150px");
                $(".testClass").css("min-height", "170px");
                $(".testClass").css("background-color", "white");
                $(".testClass").css("border-radius", "5px");
                $(".testClass").css("box-shadow", "2px 2px 3px 4px #ccc");
                $(".testClass").css("-mox-box-shadow", "2px 2px 3px 4px #ccc");
                $(".testClass").css("-webkit-box-shadow", "2px 2px 3px 4px #ccc");
                $(".testClass").css("z-index", 9999);

		if(currAssign!==undefined){
			$(".testClass").prepend("<p> Number of Students:"+ currAssign["title"].split("(")[1].split(")")[0]+"</p>");
        	        $(".testClass").prepend("<p> Meeting:" + currAssign["meeting"] + "</p>");	
			$(".testClass").prepend("<p> Code: "+ currAssign["title"].split("(")[0]+ "</p>");        		
		}else{
                        $(".testClass").prepend("<p> Number of Students:"+ currCourse["title"].split("#")[1]+"</p>");
			$(".testClass").prepend("<p> Meeting:"+ currCourse["meeting"]+"</p>");
			$(".testClass").prepend("<p> Code: "+ currCourse["title"].split("#")[0] + "</p>");
		}
	},
        function(){
                $(".testClass").remove();
        });
}
