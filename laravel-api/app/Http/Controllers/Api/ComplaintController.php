<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreComplaintRequest;
use App\Http\Requests\UpdateComplaintRequest;
use App\Models\Complaint;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ComplaintController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = Complaint::with(['facility:id,name,location', 'user:id,name,email'])
            ->orderByDesc('created_at');

        if ($request->filled('status')) {
            $query->where('status', $request->query('status'));
        }
        if ($request->filled('priority')) {
            $query->where('priority', $request->query('priority'));
        }
        if ($request->filled('facility_id')) {
            $query->where('facility_id', $request->integer('facility_id'));
        }

        return response()->json($query->paginate(min(max($request->integer('per_page', 10), 1), 100)));
    }

    public function store(StoreComplaintRequest $request): JsonResponse
    {
        $complaint = Complaint::create($request->validated());
        return response()->json(['message' => 'Complaint created successfully.', 'data' => $complaint->load(['facility', 'user'])], 201);
    }

    public function show(Complaint $complaint): JsonResponse
    {
        return response()->json(['data' => $complaint->load(['facility', 'user'])]);
    }

    public function update(UpdateComplaintRequest $request, Complaint $complaint): JsonResponse
    {
        $complaint->update($request->validated());
        return response()->json(['message' => 'Complaint updated successfully.', 'data' => $complaint->fresh()->load(['facility', 'user'])]);
    }

    public function destroy(Complaint $complaint): JsonResponse
    {
        $complaint->delete();
        return response()->json(['message' => 'Complaint deleted successfully.']);
    }
}
