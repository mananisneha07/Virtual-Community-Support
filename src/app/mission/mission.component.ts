import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-mission',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './mission.component.html',
  styleUrl: './mission.component.css'
})
export class MissionComponent {
  mission = '';
  submitted=false;

  submitForm(){
    this.submitted= true;
    console.log('Form submitted:', this.mission)
  }

}
