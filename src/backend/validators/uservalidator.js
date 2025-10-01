const bcrypt = require('bcryptjs');

class UserValidator {
    static validateemail(email){
        const emailRegex = /^[^\s@]+@(gmail\.com)$/;
        return emailRegex.test(email);
    };

    static ValidatorRegistrationData(UsersData){
        const { login_name, email, password } = UsersData

        if (!login_name || !email || !password){
            throw new Error(`All fields are required`);
        };

        if(!this.validateemail(email)){
            throw new Error(`Invalid email domain`);
        };

        if(password.length < 6){
            throw new Error(`Password must be a least 6 characters long'`)
        };

        return true;
    };


    static async validatePassword(password, hash) {
        return await bcrypt.compare(password, hash);
    };

    static async hashPassword(password) {
        const salt = await bcrypt.genSalt(10);
        return await bcrypt.hash(password, salt);
    };

    static validateLoginData(data) {
        const { email, password } = data;
        
        if (!email|| !password) {
            throw new Error('Email and password are required');
        }

        return true;
    };
};

module.exports = UserValidator;