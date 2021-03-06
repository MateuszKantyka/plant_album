User.create!( name: 'Example Admin',
              email: 'admin@mail.com',
              password: '12345678',
              password_confirmation: '12345678',
              admin: true)

User.create!( name: 'Example User',
              email: 'user@mail.com',
              password: '12345678',
              password_confirmation: '12345678',
              admin: false)

Mechanic.create!( name: "Nowak autoMechanic s.c.",
                  city: "Cięcina",
                  post_code: "34-350",
                  address: "Słoneczna 1",
                  rating: 4.6,
                  phone_number: "985 547 857",
                  description: "Best mechanic in Cięcina",
                  lat: 49.6209646,
                  lng: 19.1471016,
                  verification: true)

Mechanic.create!( name: "Kowalski optimusPrime",
                  city: "Żywiec",
                  post_code: "34-300",
                  address: "Grunwaldzka 10",
                  rating: 2.8,
                  phone_number: "254 547 778",
                  description: "Make your car great again",
                  lat: 49.6892621,
                  lng: 19.2048287,
                  verification: true)

Mechanic.create!( name: "<<Mechanic W.G.>>",
                  city: "Węgierska Górka",
                  post_code: "34-350",
                  address: "Grunwaldzka 210",
                  rating: 0,
                  phone_number: "111 111 111",
                  description: "Mechanics from wg",
                  lat: 49.6892621,
                  lng: 19.2048287,
                  verification: false)

Comment.create!( content: "Good!",
                 car: "Fiat126p",
                 cost: 100.25,
                 rating_cost: 4,
                 rating_time: 5,
                 rating_general: 5,
                 user_id: 1,
                 mechanic_id: 1)

Comment.create!( content: "Slow but fine!",
                 car: "Audi a3",
                 cost: 120.25,
                 rating_cost: 5,
                 rating_time: 2,
                 rating_general: 5,
                 user_id: 2,
                 mechanic_id: 1)

Comment.create!( content: "too expensive!",
                 car: "Fiat126p",
                 cost: 500.00,
                 rating_cost: 1,
                 rating_time: 4,
                 rating_general: 3,
                 user_id: 1,
                 mechanic_id: 2)

Comment.create!( content: "medium",
                 car: "Audi a3",
                 cost: 299.99,
                 rating_cost: 2,
                 rating_time: 3,
                 rating_general: 4,
                 user_id: 2,
                 mechanic_id: 2)
