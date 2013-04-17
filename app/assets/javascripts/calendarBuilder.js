function maxDays(year, month){
        return new Date(year, month, 0).getDate();
}

function convertDateToJS(input){
        var dateValues = input.split("-");
        return new Date(Number(dateValues[0]), Number(dateValues[1])-1, Number(dateValues[2]));
}

function buildCalendar(coursesToJSON){
        var dateSet = new Array();
        var i = 0;

        for ( i = 0; i < coursesToJSON.length; i++){
                var dateObject = new Array();

                dateObject["start"]= new Date(coursesToJSON[i].start*1000);
                dateObject["end"] = new Date(coursesToJSON[i].end*1000);

                dateObject["title"] = coursesToJSON[i].title;


                if(dateObject["start"].getMonth() == 0){
                        var endBefore = new Date(dateObject["start"].getFullYear(), 3, 8);
                }else if(dateObject["start"].getMonth() == 3){
                        var endBefore = new Date(dateObject["start"].getFullYear(), 7, 8);
                }else{
                        var endBefore = new Date(dateObject["start"].getFullYear(), 11, 6);
                }

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

        }


        $("#calendar").fullCalendar({
                header: {
                        left: 'prev, next today',
                        middle: 'title',
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
