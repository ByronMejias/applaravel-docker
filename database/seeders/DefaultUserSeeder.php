<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class DefaultUserSeeder extends Seeder
{
    public function run()
    {
        // Crear un usuario por defecto
        User::create([
            'name' => 'Usuario por Defecto',
            'email' => 'usuario@ejemplo.com',
            'password' => Hash::make('contraseña'),
        ]);
    }
}
