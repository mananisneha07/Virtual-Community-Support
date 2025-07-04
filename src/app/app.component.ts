import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { MissionComponent } from './mission/mission.component'

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet,MissionComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'form';
}
