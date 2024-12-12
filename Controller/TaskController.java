package com.example.FlutterSpringbootDemo.Controller;

import com.example.FlutterSpringbootDemo.Model.ResponseObject;
import com.example.FlutterSpringbootDemo.Model.TaskItems;
import com.example.FlutterSpringbootDemo.Repository.TaskRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.config.Task;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(path = "/tasks")
public class TaskController {
    @Autowired
    private TaskRepository taskRepository;
    @GetMapping
    public List<TaskItems>getTasks () {
        return taskRepository.findAll();
    }

    @PostMapping("/add")
    public TaskItems addTask (@Valid @RequestBody TaskItems taskItems) {
       return taskRepository.save(taskItems);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateTask(@PathVariable Long id) {
        boolean exist = taskRepository.existsById(id);
        if(exist) {
            TaskItems task = taskRepository.getById(id);
            boolean done = task.isDone();
            task.setDone(!done);
            taskRepository.save(task);
            return new ResponseEntity("updated successfully", HttpStatus.OK);
        }
        return new ResponseEntity("updated failed", HttpStatus.NOT_IMPLEMENTED);
    }

    @PutMapping("/edit/{id}")
    public ResponseEntity editTask (@PathVariable Long id, @RequestBody TaskItems newItem) {
        Optional<TaskItems> updatedItem = taskRepository.findById(id).map(item -> {
            item.setTitle(newItem.getTitle());
            item.setDone(newItem.isDone());

            return taskRepository.save(item);
        });

        return updatedItem.isPresent() ?
                ResponseEntity.status(HttpStatus.OK).body(
                        new ResponseObject("ok", "Update successful", updatedItem.get())
                ) :
                ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                        new ResponseObject("none", "Cannot find product with ID so we create a new one" + id, taskRepository.save(newItem))
                );

    }


    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteTask (@PathVariable Long id) {
        boolean isExisted = taskRepository.existsById(id);
        if(isExisted) {
            taskRepository.deleteById(id);
            return new ResponseEntity("delete successfully", HttpStatus.OK);
        }
        return new ResponseEntity("updated failed", HttpStatus.NOT_IMPLEMENTED);
    }

}
