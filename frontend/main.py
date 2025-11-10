import streamlit as st
import requests

API_url = "https://chatbotcloud.up.railway.app/chat"


st.set_page_config(page_title="Chatbot Cloud")

st.title("Chatbot")

message = st.text_area("Input")

if st.button("Send", type="primary"):
    if message.strip():
        try:
            with st.spinner("Sending..."):
                response = requests.post(
                    API_url,
                    data=message,
                    timeout=30
                )
                
                if response.status_code == 200:
                    output = response.json()
                    st.subheader("Output:")
                    st.write(output)
                else:
                    st.error(f"Failed to process message: {response}")
        
        except requests.exceptions.RequestException as e:
            st.error(f"Conection error: {str(e)}")       
    else:
        st.warning("Please type a message") 