function makeRatingFunc(user_id, drink_id) {
  return function(event, value) {
    let rating = {
      user_id: user_id,
      drink_id: drink_id,
      rating: value
    }
  
    $.post('/rating', rating, function(resp) {
      $("#current_rating").rating("update", resp.rating)
    }, "json")
  }
}