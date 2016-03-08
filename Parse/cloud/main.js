// For example:
Parse.Cloud.afterSave('Recipe', function(req) {
        var voters = req.object.relation('lickers');
        voters.query().count({
                success: function(count) {
                        req.object.set('numberOfLicks', count)
                        req.object.save();
                },
                error: function(error) {
              console.error("Got an error " + error.code + " : " + error.message);
                }
        });
});

//    Parse.Cloud.define("addIngrToRecipeRelation", function(request, response) {
// //
//     Parse.Cloud.useMasterKey();
//     //get the friend requestId from params
//     var friendRequestId = request.params.ingredients;
//     var query = new Parse.Query(Parse.User);
// 
//     //get the friend request object
//     query.get(friendRequestId, {
//         success: function(friendRequest) {
// 
//             //get the user the request was from
//             var fromUser = friendRequest;
//             //get the user the request is to
//             var toUser = Parse.User.current() ;
// 
//             var relation = fromUser.relation("Friends");
//             //add the user the request was to (the accepting user) to the fromUsers friends
//             relation.add(toUser);
// 
//             //save the fromUser
//             fromUser.save(null, {
// 
//                 success: function() {
// 
//                      response.success("saved relation and updated friendRequest");
// 
//                 },
// 
//                 error: function(error) {
// 
//                 response.error(error);
// 
//                 }
// 
//             });
// 
//         },
// 
//         error: function(error) {
// 
//             response.error(error);
//         }
// 
//     });
// 
// });
