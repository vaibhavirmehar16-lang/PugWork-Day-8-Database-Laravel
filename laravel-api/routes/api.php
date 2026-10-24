<?php

use App\Http\Controllers\Api\ComplaintController;
use App\Http\Controllers\Api\FacilityController;
use App\Http\Controllers\Api\InspectionController;
use Illuminate\Support\Facades\Route;

Route::get('/health', fn () => response()->json([
    'status' => 'ok',
    'service' => 'Day 8 Facility Management API',
]));

Route::apiResource('facilities', FacilityController::class);
Route::apiResource('inspections', InspectionController::class);
Route::apiResource('complaints', ComplaintController::class);
