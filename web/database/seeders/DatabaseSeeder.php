<?php

namespace Database\Seeders;

use App\Models\Movie;
use App\Models\Review;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Add an example user

        $user = User::create([
            'name' => 'Example User',
            'email' => 'example@user.com',
            'password' => Hash::make('Demo@123'),
        ]);

        // Add some example movies

        $movie1 = Movie::create([
            'slug' => 'lord-of-the-rings--the-fellowship-of-the-ring',
            'title' => 'The Lord of the Rings: The Fellowship of the Ring',
            'description' => 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.',
            'released' => '2001-12-19',
        ]);

        $movie2 = Movie::create([
            'slug' => 'lord-of-the-rings--the-two-towers',
            'title' => 'The Lord of the Rings: The Two Towers',
            'description' => 'While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Sauron\'s new ally, Saruman, and his hordes of Isengard.',
            'released' => '2002-12-18',
        ]);

        // Add some example reviews

        Review::create([
            'movie_id' => $movie1->id,
            'user_id' => $user->id,
            'rating' => 5,
            'review' => 'Loved the movie!',
        ]);

        Review::create([
            'movie_id' => $movie2->id,
            'user_id' => $user->id,
            'rating' => 4,
            'review' => 'Good movie but I preferred the Fellowship of the Ring.',
        ]);
    }
}
