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
        const result = await base('Users').select({
            filterByFormula: `cognito_id = \"${event.arguments.id}\"`,
            maxRecords: 1
        }).all();
        
        return result[0]?.fields;
    } catch (e) {
        console.log(e.data.error)
        return callback(e);
    }
};
