<?php

use App\Models\Quote;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    $env = Config::get('app.env');
    $allQuotes = Quote::count();
    $randomIndex = rand(1, $allQuotes);
    $quote = Quote::find($randomIndex);
    return view('quotes', ["quote" => $quote->quote, "author" => $quote->author, "env" => $env]);
});

Route::get('/{id}', function ($id) {
    $env = Config::get('app.env');
    $quote = Quote::find($id);
    return view('quotes', ["quote" => $quote->quote, "author" => $quote->author, "env" => $env]);
});
