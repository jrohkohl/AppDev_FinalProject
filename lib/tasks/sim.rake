task({:sim=> :environment}) do 


  check_user = User.where({ :id => 3 }).at(0)
  all_users = User.all.order({ :created_at => :desc }).sample(30)
  all_rest = Restaurant.all.order({ :created_at => :desc })

  user_sample_id_array = []
  user_sample_sim_array = []
  final_user_array = []

  
  

  all_users.each do |u|

    sum_product = 0.0
    sum_check_sq = 0.0
    sum_u_sq = 0.0

    if u.id != check_user.id
      
      all_rest.each do |r|

        adj_check_rating = 0
        adj_u_rating = 0


        check_rating = check_user.ratings.where({ :restaurant_id => r.id }).at(0)
      

        u_rating = u.ratings.where({ :restaurant_id => r.id }).at(0)

        
        
        
        if check_rating.nil?  
          adj_check_rating = 0

        elsif check_rating.rating == 2 || check_rating.rating == 3
          adj_check_rating = 0
        
        elsif  check_rating.rating == 4 || check_rating.rating == 5
          adj_check_rating = 1
        else
          adj_check_rating = -1
        end

        if u_rating.nil?
          adj_u_rating = 0

        elsif u_rating.rating == 2 || u_rating.rating == 3
          adj_u_rating = 0
        
        elsif  u_rating.rating == 4 || u_rating.rating == 5
          adj_u_rating = 1
        else
          adj_u_rating = -1
        end
        
        sum_product = sum_product + (adj_u_rating * adj_check_rating)
        sum_check_sq = (adj_check_rating ** 2) + sum_check_sq
        sum_u_sq = (adj_check_rating ** 2) + sum_u_sq


      end 
      user_sim = sum_product / ((sum_check_sq ** 0.5) * (sum_u_sq ** 0.5))

      user_sample_id_array.push(u.id)
      user_sample_sim_array.push(user_sim)

    else 
      user_sim = 0.0
    end 
  
  end

  num_users = user_sample_id_array.count
  if num_users > 9 
      10.times do

      max_index = user_sample_sim_array.index(user_sample_sim_array.max)
      final_user_array.push(user_sample_id_array.at(user_sample_sim_array.index(user_sample_sim_array.max)))
      user_sample_sim_array.delete_at(max_index)
      user_sample_id_array.delete_at(max_index)

    end


  else
    num_users.times do

      max_index = user_sample_sim_array.index(user_sample_sim_array.max)
      final_user_array.push(user_sample_id_array.at(user_sample_sim_array.index(user_sample_sim_array.max)))
      user_sample_sim_array.delete_at(max_index)
      user_sample_id_array.delete_at(max_index)

    end
  end 

  p final_user_array

  
  ratings_of_similar_users = Rating.where({ :user_id => final_user_array })
  best_ratings_of_similar_users = Rating.where({ :user_id => final_user_array }).where( "rating > ?", 3.9 )
  rec_rest_id = best_ratings_of_similar_users.distinct.pluck(:restaurant_id)

  sampled_rec_rest_id = rec_rest_id.sample(5)

  my_rated_rest_id = check_user.ratings.pluck(:restaurant_id)

  suggested_ids = rec_rest_id.difference(my_rated_rest_id)
  

  p Restaurant.where({ :id => suggested_ids}).at(0).name

 
 
  
  

  




end