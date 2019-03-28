package com.zxl.studygradle;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.zxl.library.Common;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        System.out.println("---"+ Common.test);

    }
}
