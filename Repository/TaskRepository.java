package com.example.FlutterSpringbootDemo.Repository;

import com.example.FlutterSpringbootDemo.Model.TaskItems;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TaskRepository extends JpaRepository<TaskItems, Long> {
}
