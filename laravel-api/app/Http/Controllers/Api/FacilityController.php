<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreFacilityRequest;
use App\Http\Requests\UpdateFacilityRequest;
use App\Models\Facility;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class FacilityController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $perPage = min(max((int) $request->query('per_page', 10), 1), 100);
        $query = Facility::query()->withCount(['inspections', 'complaints'])->orderBy('name');

        if ($request->filled('search')) {
            $search = $request->string('search')->toString();
            $query->where(fn ($q) => $q->where('name', 'like', "%{$search}%")
                ->orWhere('location', 'like', "%{$search}%"));
        }

        return response()->json($query->paginate($perPage));
    }

    public function store(StoreFacilityRequest $request): JsonResponse
    {
        $facility = Facility::create($request->validated());
        return response()->json(['message' => 'Facility created successfully.', 'data' => $facility], 201);
    }

    public function show(Facility $facility): JsonResponse
    {
        return response()->json(['data' => $facility->load([
            'inspections' => fn ($q) => $q->latest('inspection_date')->limit(10),
            'complaints' => fn ($q) => $q->latest()->limit(10),
        ])]);
    }

    public function update(UpdateFacilityRequest $request, Facility $facility): JsonResponse
    {
        $facility->update($request->validated());
        return response()->json(['message' => 'Facility updated successfully.', 'data' => $facility->fresh()]);
    }

    public function destroy(Facility $facility): JsonResponse
    {
        $facility->delete();
        return response()->json(['message' => 'Facility deleted successfully.']);
    }
}
