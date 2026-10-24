<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('inspections', function (Blueprint $table) {
            $table->id();
            $table->foreignId('facility_id')->constrained()->cascadeOnDelete();
            $table->foreignId('inspector_id')->constrained('employees')->restrictOnDelete();
            $table->date('inspection_date');
            $table->decimal('cleanliness_score', 4, 2);
            $table->unsignedTinyInteger('odor_score')->default(1);
            $table->enum('waste_level', ['low', 'medium', 'high', 'critical'])->default('low');
            $table->text('notes')->nullable();
            $table->timestamps();
            $table->index(['facility_id', 'inspection_date']);
            $table->index(['waste_level', 'inspection_date']);
        });
    }

    public function down(): void { Schema::dropIfExists('inspections'); }
};
