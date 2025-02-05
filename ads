<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pixel Ad Grid</title>
    <style>
        body {
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background: #f0f0f0;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(100, 10px);
            grid-template-rows: repeat(100, 10px);
            gap: 1px;
        }
        .pixel {
            width: 10px;
            height: 10px;
            background: white;
            border: 1px solid #ddd;
            cursor: pointer;
        }
        .pixel:hover {
            background: #ccc;
        }
        .info {
            margin-bottom: 10px;
            font-size: 16px;
            font-weight: bold;
        }
        .form-container {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            z-index: 10;
        }
        .form-container input {
            display: block;
            margin: 10px 0;
            padding: 5px;
            width: 100%;
        }
        .form-container button {
            padding: 5px 10px;
            margin-top: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="info">Each pixel costs INR 1000</div>
    <div class="grid" id="grid"></div>
    
    <div class="form-container" id="form-container">
        <h3>Enter Your Details</h3>
        <input type="text" id="company-url" placeholder="Company Web Address" required>
        <input type="text" id="contact-details" placeholder="Contact Details" required>
        <button onclick="submitForm()">Proceed to Payment</button>
        <button onclick="closeForm()">Cancel</button>
    </div>

    <script>
        const grid = document.getElementById("grid");
        const pixelData = {}; // Stores pixel links and payment status
        let selectedPixel = null;

        function openForm(pixelIndex, pixelElement) {
            selectedPixel = { index: pixelIndex, element: pixelElement };
            document.getElementById("form-container").style.display = "block";
        }

        function closeForm() {
            document.getElementById("form-container").style.display = "none";
        }

        function submitForm() {
            const companyUrl = document.getElementById("company-url").value;
            const contactDetails = document.getElementById("contact-details").value;
            
            if (!companyUrl || !contactDetails) {
                alert("Please enter all details.");
                return;
            }
            
            closeForm();
            initiatePayment(selectedPixel.index, selectedPixel.element, companyUrl, contactDetails);
        }

        function initiatePayment(pixelIndex, pixelElement, companyUrl, contactDetails) {
            let paymentUrl = `https://paytm.com/payment?amount=1000&pixel=${pixelIndex}`; // Replace with actual Paytm merchant URL
            window.open(paymentUrl, "_blank");
            
            setTimeout(() => {
                let confirmed = confirm("Payment successful? Click OK to confirm purchase.");
                if (confirmed) {
                    pixelData[pixelIndex] = { url: companyUrl, contact: contactDetails, paid: true };
                    pixelElement.style.background = "#ff0"; // Mark as sold
                    alert("Pixel purchased successfully!");
                }
            }, 5000); // Simulating payment processing delay
        }

        for (let i = 0; i < 10000; i++) {
            let pixel = document.createElement("div");
            pixel.classList.add("pixel");
            pixel.dataset.index = i;
            
            pixel.addEventListener("click", (event) => {
                if (!pixelData[i]) {
                    openForm(i, event.target);
                } else {
                    alert("Pixel already purchased!");
                }
            });

            pixel.addEventListener("dblclick", (event) => {
                if (pixelData[i] && pixelData[i].paid) {
                    window.open(pixelData[i].url, "_blank");
                }
            });
            
            grid.appendChild(pixel);
        }
    </script>
</body>
</html>
