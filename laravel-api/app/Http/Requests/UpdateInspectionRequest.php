<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateInspectionRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'facility_id' => ['sometimes', 'required', 'integer', 'exists:facilities,id'],
            'inspector_id' => ['sometimes', 'required', 'integer', 'exists:employees,id'],
            'inspection_date' => ['sometimes', 'required', 'date'],
            'cleanliness_score' => ['sometimes', 'required', 'numeric', 'between:0,10'],
            'odor_score' => ['sometimes', 'required', 'integer', 'between:1,5'],
            'waste_level' => ['sometimes', 'required', Rule::in(['low', 'medium', 'high', 'critical'])],
            'notes' => ['nullable', 'string', 'max:5000'],
        ];
    }
}
