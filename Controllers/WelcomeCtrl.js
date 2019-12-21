
class Welcome {
    constructor(request, response, con) {
        this.request = request;
        this.response = response;
        this.con = con;
        this.init();
    }

    async init() {
        let params = {};
        
        this.response.render("html/Welcome.ejs", params);
    }
}
module.exports = Welcome;

