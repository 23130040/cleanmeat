function openAddTransportModal() {
    document.getElementById('addTransportModal').classList.add('show');
}

function closeAddTransportModal() {
    document.getElementById('addTransportModal').classList.remove('show');
}

function openEditTransportModal(id, name, fee, days, freeShip) {
    document.getElementById('edit-transport-id').value = id;
    document.getElementById('edit-transport-name').value = name;
    document.getElementById('edit-transport-fee').value = fee;
    document.getElementById('edit-transport-days').value = days;
    document.getElementById('edit-transport-free-ship').value = freeShip;
    document.getElementById('editTransportModal').classList.add('show');
}

function closeEditTransportModal() {
    document.getElementById('editTransportModal').classList.remove('show');
}
