package com.zxl.studygradle;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.btzh.pagelement.hybrid.HyConstants;
import com.btzh.pagelement.hybrid.WebCommons;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        System.out.println("---"+HyConstants.BTZH_CALLBACK_NAV_LEFT_BACK);

    }
}
