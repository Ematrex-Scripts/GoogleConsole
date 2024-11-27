import requests
import subprocess
import time
import sys
def fetch_api_data(api_url):
    """Fetch data from the API."""
    try:
        response = requests.get(api_url)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching API data: {e}")
        return None

def execute_script( body, header, datalists):
    """Execute the email sending script."""
    if not all([ body, header, datalists]):
        print("Error: Missing required parameters.")
        return

    if not isinstance(datalists, list):
        print("Error: datalists must be a list of emails.")
        return

    # Convert the datalists to a comma-separated string
    datalists_str = ",".join(datalists)

    script_path = "./send.sh"
    command = f"{script_path} '{body}' '{header}' '{datalists_str}'"

    try:
        result = subprocess.run(command, shell=True, check=True, text=True, stderr=subprocess.PIPE)
        print("Script executed successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error executing script: {e.stderr}")

if __name__ == "__main__":
    domain = sys.argv[1]
    from_email = sys.argv[2]
    api_url = "http://"+domain+"/Google-Console"+"/"+from_email

    print("Starting the infinite loop...")
   
    # Fetch JSON data from the API
    data = fetch_api_data(api_url)

    if data:
            # Extract parameters from the JSON response
 

            body = data.get("body")
            header = data.get("header")
            datalists = data.get("datalists")

            # Execute the email sending script
            execute_script(body, header, datalists)
    else:
            print("Failed to fetch data.")

 

