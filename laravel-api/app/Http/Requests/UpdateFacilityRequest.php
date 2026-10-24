<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateFacilityRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'name' => ['sometimes', 'required', 'string', 'max:150'],
            'location' => ['sometimes', 'required', 'string', 'max:180'],
            'cleanliness_score' => ['sometimes', 'numeric', 'between:0,10'],
            'status' => ['sometimes', Rule::in(['active', 'maintenance', 'closed'])],
        ];
    }
}
