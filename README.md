# Event Web App

## Overview
This is a static web application built using Python and Flask to showcase an event in a professional and engaging manner. The app includes key sections such as Home, About, Schedule, and Contact, ensuring a seamless user experience. The design emphasizes professionalism, ease of navigation, and visual appeal.

---

## Features

### 1. **Home**
- Welcomes users with an engaging tagline and call-to-action button.
- Highlights the essence of the event and creates a strong first impression.

### 2. **About**
- Provides a detailed overview of the event.
- Explains the mission and key highlights of the event.

### 3. **Schedule**
- Displays the event agenda with time slots, session titles, and descriptions.
- Designed for easy readability and clarity.

### 4. **Contact**
- Includes a contact form for inquiries.
- Provides additional contact details such as email, phone, and social media links.

---

## File Structure

```
Event-Web-App/
├── app.py           # Main Flask Application
├── templates/       # HTML Templates
│   ├── base.html    
│   ├── index.html  
│   ├── about.html   
│   ├── schedule.html 
│   └── contact.html 
├── static/          
│   ├── styles.css   
│   └── images/      
└── requirements.txt 

```

---

## Technologies Used
- **Python**: Backend logic and server-side functionality.
- **Flask**: Lightweight web framework for Python.
- **HTML5**: For creating the structure of the app.
- **CSS3**: For styling and making the design visually appealing.

---

## Installation and Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/sparknet-innovations/event-web-app.git
   ```

2. Navigate to the project directory:
   ```bash
   cd event-web-app
   ```

3. Create a virtual environment and activate it:
   ```bash
   python -m venv venv
   source venv/bin/activate   # On Windows: venv\Scripts\activate
   ```

4. Install the required dependencies:
   ```bash
   pip install -r requirements.txt
   ```

5. Run the Flask application:
   ```bash
   python app.py
   ```

6. Open your browser and navigate to:
   ```
   http://127.0.0.1:5000
   ```
