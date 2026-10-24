<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('employees', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->unique()->constrained()->nullOnDelete();
            $table->foreignId('department_id')->constrained()->restrictOnDelete();
            $table->string('employee_code', 30)->unique();
            $table->string('job_title', 100);
            $table->decimal('salary', 12, 2);
            $table->date('hire_date');
            $table->timestamps();
            $table->index(['department_id', 'salary']);
        });
    }

    public function down(): void { Schema::dropIfExists('employees'); }
};
