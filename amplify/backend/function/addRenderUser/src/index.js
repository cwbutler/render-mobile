/* Amplify Params - DO NOT EDIT
	ENV
	REGION
	AIRTABLE_API_KEY
Amplify Params - DO NOT EDIT */
const Airtable = require('airtable');
const base = new Airtable({apiKey: process.env.AIRTABLE_API_KEY}).base('appo8ITXRoiHVVPoe');

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event, _, callback) => {
    try {
        const result = await base('Users').create(event.arguments.input);
        return result?.fields;
    } catch (e) {
        console.log(e.data.error)
        return callback(e);
    }
};
