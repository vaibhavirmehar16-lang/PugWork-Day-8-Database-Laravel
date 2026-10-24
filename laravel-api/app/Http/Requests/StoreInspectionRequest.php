<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreInspectionRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'facility_id' => ['required', 'integer', 'exists:facilities,id'],
            'inspector_id' => ['required', 'integer', 'exists:employees,id'],
            'inspection_date' => ['required', 'date'],
            'cleanliness_score' => ['required', 'numeric', 'between:0,10'],
            'odor_score' => ['required', 'integer', 'between:1,5'],
            'waste_level' => ['required', Rule::in(['low', 'medium', 'high', 'critical'])],
            'notes' => ['nullable', 'string', 'max:5000'],
        ];
    }
}
