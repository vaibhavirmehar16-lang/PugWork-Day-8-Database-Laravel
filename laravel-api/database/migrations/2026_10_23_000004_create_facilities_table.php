<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('facilities', function (Blueprint $table) {
            $table->id();
            $table->string('name', 150);
            $table->string('location', 180);
            $table->decimal('cleanliness_score', 4, 2)->default(5.00);
            $table->enum('status', ['active', 'maintenance', 'closed'])->default('active');
            $table->timestamps();
            $table->index('location');
            $table->index('cleanliness_score');
        });
    }

    public function down(): void { Schema::dropIfExists('facilities'); }
};
