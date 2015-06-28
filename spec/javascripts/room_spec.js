//preload the fixture so that it loads faster
fixture.preload("room.html"); // make the actual requests for the files

describe("Using fixtures", function() {


    beforeEach(function() {
        //setup the fixture that we have previously required
        //initialize();
        this.fixtures = fixture.load("room.html", true); // append these fixtures which were already cached
    });

    


});