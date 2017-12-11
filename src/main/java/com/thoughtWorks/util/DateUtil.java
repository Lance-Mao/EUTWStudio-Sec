package com.thoughtWorks.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DateUtil {

    public static String nowDateToYMDSMS() {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return formatter.format(currentTime);
    }

    public static List<Integer> getSearchLevels() {
        List<Integer> levels = new ArrayList<>();
        Calendar calendar = Calendar.getInstance();

        int currentMonth = calendar.get(Calendar.MONTH) + 1;
        int currentYear = calendar.get(Calendar.YEAR);
        if (currentMonth >= 8) levels.add(currentYear);

        levels.add(currentYear - 1);
        levels.add(currentYear - 2);
        if (currentMonth < 8) levels.add(currentYear - 3);

        return levels;
    }
}
