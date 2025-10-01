const UserValidator = require(`../validators/uservalidator`);
const UsersRepository = require(`../repositories/usersrepository`);

class UserService{

    async register(UsersData){
        UserValidator.ValidatorRegistrationData(UsersData);

        const existinguser = await UsersRepository.FindUsers(UsersData.email);
        if (existinguser) {
                throw new Error('User already exists');
            };

            const hashedPassword = await UserValidator.hashPassword(UsersData.password);
            UsersData.password = hashedPassword;

        const user = await UsersRepository.CreateUser(UsersData);

        return user;
    };

    async login(loginData){
        UserValidator.validateLoginData(loginData);

        const user = await UsersRepository.FindUsers(loginData.email);
            if (!user) {
                throw new Error('User not found');
            };

            const isValidPassword = await UserValidator.validatePassword(
                loginData.password, 
                user.password
            );

             if (!isValidPassword) {
                throw new Error('Invalid password');
            }

            return {
                user: {
                    user_id: user.user_id,
                    email: user.email
                }
             }
    }
}

module.exports = new UserService();