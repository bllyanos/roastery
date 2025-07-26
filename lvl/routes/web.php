<?php

use App\Models\Quote;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    $allQuotes = Quote::count();
    $randomIndex = rand(1, $allQuotes);
    $quote = Quote::find($randomIndex);
    return view('quotes', ["quote" => $quote->quote, "author" => $quote->author]);
});

Route::get('/{id}', function ($id) {
    $quote = Quote::find($id);
    return view('quotes', ["quote" => $quote->quote, "author" => $quote->author]);
});
