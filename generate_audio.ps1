Add-Type -AssemblyName System.Speech
$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$synth.SetOutputToWaveFile("C:\Users\samet\.gemini\antigravity\brain\0025c366-76bf-4dc9-9619-668146541df1\voiceover.wav")
$synth.Rate = 0

# Introduction
$synth.Speak("Welcome to the Hospital Appointment System API verification.")
Start-Sleep -Milliseconds 500

# Step 1
$synth.Speak("Step 1. Fetching available doctors from the API.")
Start-Sleep -Milliseconds 2000
$synth.Speak("Success! Found doctors in the system.")
Start-Sleep -Milliseconds 2000

# Step 2
$synth.Speak("Step 2. Creating a new appointment for Doctor House.")
Start-Sleep -Milliseconds 2000
$synth.Speak("Appointment booked successfully. Status: scheduled.")
Start-Sleep -Milliseconds 1000

$synth.Speak("API verification complete.")

$synth.Dispose()
Write-Host "Audio file created successfully at: C:\Users\samet\.gemini\antigravity\brain\0025c366-76bf-4dc9-9619-668146541df1\voiceover.wav"
