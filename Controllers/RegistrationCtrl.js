
class Registration {
    constructor(request, response, con) {
        this.request = request;
        this.response = response;
        this.con = con;
        this.init();
    }

    async init() {
        let params = {};
        
        this.response.render("html/Registration.ejs", params);
    }
}
module.exports = Registration;

