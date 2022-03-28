<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTodoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('todo', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('category')->default('Main');
            // TODO : Category receives another table to make a selects better. ps : forgot the word to do what i want
            $table->string('task');
            $table->string('statusTask')->default('Pending');
            // TODO : Status need to be : Started,Pending and Finished.
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('todo');
    }
}
