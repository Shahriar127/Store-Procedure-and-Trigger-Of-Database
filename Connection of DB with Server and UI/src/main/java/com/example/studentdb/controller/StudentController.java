package com.example.studentdb.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
public class StudentController {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @PostMapping("/create-table")
    public String createTable() {
        String sql = "CREATE TABLE IF NOT EXISTS student (id BIGINT PRIMARY KEY, name VARCHAR(100), dept VARCHAR(100), mobile_no VARCHAR(100)";
        jdbcTemplate.execute(sql);
        return "Table created";
    }

    @PostMapping("/add-student")
    public String addStudent(@RequestBody Map<String, Object> payload) {

        String createTableSql = "CREATE TABLE IF NOT EXISTS student (id BIGINT PRIMARY KEY, name VARCHAR(100), dept VARCHAR(100)), mobile_no VARCHAR(100)";
        jdbcTemplate.execute(createTableSql);


        long id = Long.parseLong(payload.get("id").toString());
        String name = payload.get("name").toString();
        String dept = payload.get("dept").toString();
        String mobile_no = payload.get("mobile_no").toString();
        String insertSql = "INSERT INTO student (id, name, dept) VALUES (?, ?, ?)";
        jdbcTemplate.update(insertSql, id, name, dept,mobile_no);

        return "Student added successfully";
    }

    @DeleteMapping("/delete-table")
    public String deleteTable() {
        String sql = "DROP TABLE IF EXISTS student";
        jdbcTemplate.execute(sql);
        return "Table deleted";
    }
}
