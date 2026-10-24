<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Inspection extends Model
{
    use HasFactory;

    protected $fillable = [
        'facility_id', 'inspector_id', 'inspection_date',
        'cleanliness_score', 'odor_score', 'waste_level', 'notes',
    ];

    protected function casts(): array
    {
        return [
            'inspection_date' => 'date',
            'cleanliness_score' => 'decimal:2',
            'odor_score' => 'integer',
        ];
    }

    public function facility(): BelongsTo
    {
        return $this->belongsTo(Facility::class);
    }

    public function inspector(): BelongsTo
    {
        return $this->belongsTo(Employee::class, 'inspector_id');
    }
}
