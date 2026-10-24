<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreInspectionRequest;
use App\Http\Requests\UpdateInspectionRequest;
use App\Models\Inspection;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class InspectionController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = Inspection::with(['facility:id,name,location', 'inspector.user:id,name'])
            ->orderByDesc('inspection_date');
        if ($request->filled('facility_id')) {
            $query->where('facility_id', $request->integer('facility_id'));
        }
        if ($request->filled('waste_level')) {
            $query->where('waste_level', $request->query('waste_level'));
        }
        return response()->json($query->paginate(min(max($request->integer('per_page', 10), 1), 100)));
    }

    public function store(StoreInspectionRequest $request): JsonResponse
    {
        $inspection = Inspection::create($request->validated());
        return response()->json(['message' => 'Inspection created successfully.', 'data' => $inspection->load('facility')], 201);
    }

    public function show(Inspection $inspection): JsonResponse
    {
        return response()->json(['data' => $inspection->load(['facility', 'inspector.user'])]);
    }

    public function update(UpdateInspectionRequest $request, Inspection $inspection): JsonResponse
    {
        $inspection->update($request->validated());
        return response()->json(['message' => 'Inspection updated successfully.', 'data' => $inspection->fresh()->load('facility')]);
    }

    public function destroy(Inspection $inspection): JsonResponse
    {
        $inspection->delete();
        return response()->json(['message' => 'Inspection deleted successfully.']);
    }
}
