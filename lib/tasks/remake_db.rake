namespace :db do
    namespace :remake do
        #run from command line with "rake db:remake:dev"
        task :dev => :environment do
                ENV['RAILS_ENV'] = 'development'
                Rake::Task['db:reset'].invoke
                Rake::Task['db:remake:recreate_db'].invoke
        end

        task :prod => :environment do
            ENV['RAILS_ENV'] = 'production'
            Rake::Task['db:remake:recreate_db'].invoke
        end

        task :recreate_db => :environment do
            user_data = []
            #create 10 users
            for i in 0..9
                    user_data.append({
                            email: "avogel"+i.to_s+"@mit.edu",
                            phone_number: "+1818577662"+i.to_s
                    })
            end
            users = []

            for user_info in user_data
                    user = User.create(
                            email: user_info[:email],
                            phone_number: user_info[:phone_number],
                            password: "password",
                            password_confirmation: "password"
                    )
                    users.append(user)
            end

            date_1 = Date.today
            date_2 = Date.today+1
            date_3 = Date.today+3

            for user in users
                # three entries on one date
                for i in 1..3
                    Entry.create(
                        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sapien tellus, malesuada non dolor a, dapibus gravida eros. Aenean adipiscing vehicula nisl, nec laoreet augue dignissim id. Maecenas vestibulum, odio eu gravida tempus, libero lacus bibendum lectus, in porta tortor neque ac sem. Nullam sit amet mattis neque. Vivamus volutpat tortor ante. Vivamus in tristique enim. Praesent euismod lectus est, id cursus sapien eleifend quis. Nullam elementum magna at mi aliquam aliquam. Curabitur ac metus urna. Morbi nec tortor blandit nulla consectetur faucibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
                        user_id: user.id,
                        submit_date: date_1
                    )
                end

                #two more entries on another
                for i in 1..2
                    Entry.create(
                        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sapien tellus, malesuada non dolor a, dapibus gravida eros. Aenean adipiscing vehicula nisl, nec laoreet augue dignissim id. Maecenas vestibulum, odio eu gravida tempus, libero lacus bibendum lectus, in porta tortor neque ac sem. Nullam sit amet mattis neque. Vivamus volutpat tortor ante. Vivamus in tristique enim. Praesent euismod lectus est, id cursus sapien eleifend quis. Nullam elementum magna at mi aliquam aliquam. Curabitur ac metus urna. Morbi nec tortor blandit nulla consectetur faucibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
                        user_id: user.id,
                        submit_date: date_2
                    )
                end
                #one entry on another
                Entry.create(
                    body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sapien tellus, malesuada non dolor a, dapibus gravida eros. Aenean adipiscing vehicula nisl, nec laoreet augue dignissim id. Maecenas vestibulum, odio eu gravida tempus, libero lacus bibendum lectus, in porta tortor neque ac sem. Nullam sit amet mattis neque. Vivamus volutpat tortor ante. Vivamus in tristique enim. Praesent euismod lectus est, id cursus sapien eleifend quis. Nullam elementum magna at mi aliquam aliquam. Curabitur ac metus urna. Morbi nec tortor blandit nulla consectetur faucibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
                    user_id: user.id,
                    submit_date: date_3
                )
            end
        end
    end
end