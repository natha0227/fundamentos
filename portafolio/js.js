document.addEventListener('DOMContentLoaded', function() {
    let proveedores = [{
        id: '1',
        name: 'Juan Pérez',
        email: 'juan@example.com',
        phone: '+1234567890',
        company: 'Tech Solutions SA',
        address: 'Av. Principal 123, Ciudad',
        category: 'Tecnología',
        status: 'active',
        created_at: '2024-01-15T10:00:00Z',
        updated_at: '2024-01-15T10:00:00Z'
    }];
    
    let editarProveedor = null;
    let eliminarConfirm = null;
    let consultaBusquedad = '';
    
    init();

    function init() {
        cargarProveedores();
        enlazarEventos();
    }

    function enlazarEventos() {
        // Formulario
        const providerForm = document.getElementById('provider-form');
        if (providerForm) {
            providerForm.addEventListener('submit', submitFormulario);
        }
        
        const cancelButtons = document.querySelectorAll('#cancel-edit, #cancel-btn');
        cancelButtons.forEach(btn => {
            btn.addEventListener('click', cancelEdit);
        });
        
        // Búsqueda
        const searchInput = document.getElementById('search-input');
        if (searchInput) {
            searchInput.addEventListener('input', buscarProveedor);
        }
        
        // Limpiar errores al escribir
        const formInputs = document.querySelectorAll('#provider-form input, #provider-form select');
        formInputs.forEach(input => {
            input.addEventListener('input', function() {
                limpiarCampoError(this.getAttribute('name'));
            });
            input.addEventListener('change', function() {
                limpiarCampoError(this.getAttribute('name'));
            });
        });
    }

    function buscarProveedor() {
        const searchInput = document.getElementById('search-input');
        consultaBusquedad = searchInput ? searchInput.value.toLowerCase() : '';
        console.log(consultaBusquedad);
        cargarProveedores();
    }

    function submitFormulario(e) {
        e.preventDefault();
        
        if (!validateForm()) {
            return;
        }
        
        // obtenemos los datos del formulario
        const formData = getFormData();
        
        // si no es editar entonces es crear proveedor
        if (editarProveedor) {
            actulizarProveedor(formData);
        } else {
            crearProveedor(formData);
        }
    }

    // función para obtener los valores del formulario
    function getFormData() {
        return {
            name: getValue('name').trim(),
            email: getValue('email').trim(),
            phone: getValue('phone').trim(),
            company: getValue('company').trim(),
            address: getValue('address').trim(),
            category: getValue('category'),
            status: getValue('status')
        };
    }

    function getValue(id) {
        const element = document.getElementById(id);
        return element ? element.value : '';
    }

    /** funciones de validacion */
    function validateForm() {
        let isValid = true;
        const formData = getFormData();

        // Limpiar errores previos
        limpiarTodosErrores();

        // Validar nombre
        if (!formData.name) {
            mostarCampoError('name', 'El nombre es requerido');
            isValid = false;
        }

        // Validar email
        if (!formData.email) {
            mostarCampoError('email', 'El email es requerido');
            isValid = false;
        } else if (!validarEmail(formData.email)) {
            mostarCampoError('email', 'Email inválido');
            isValid = false;
        }

        // Validar teléfono
        if (!formData.phone) {
            mostarCampoError('phone', 'El teléfono es requerido');
            isValid = false;
        }

        // Validar empresa
        if (!formData.company) {
            mostarCampoError('company', 'La empresa es requerida');
            isValid = false;
        }

        // Validar dirección
        if (!formData.address) {
            mostarCampoError('address', 'La dirección es requerida');
            isValid = false;
        }

        // Validar categoría
        if (!formData.category) {
            mostarCampoError('category', 'La categoría es requerida');
            isValid = false;
        }

        return isValid;
    }

    function validarEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    function mostarCampoError(nomCampo, mensaje) {
        const campo = document.getElementById(nomCampo);
        const errorElement = document.getElementById(`${nomCampo}-error`);
        
        if (campo) {
            campo.classList.add('error');
        }
        if (errorElement) {
            errorElement.textContent = mensaje;
            errorElement.classList.add('show');
        }
    }

    function limpiarCampoError(nomCampo) {
        const campo = document.getElementById(nomCampo);
        const errorElement = document.getElementById(`${nomCampo}-error`);
        
        if (campo) {
            campo.classList.remove('error');
        }
        if (errorElement) {
            errorElement.classList.remove('show');
        }
    }

    function limpiarTodosErrores() {
        const inputs = document.querySelectorAll('.form-group input, .form-group select');
        const errorMessages = document.querySelectorAll('.error-message');
        
        inputs.forEach(input => {
            input.classList.remove('error');
        });
        
        errorMessages.forEach(error => {
            error.classList.remove('show');
        });
    }

    // METODOS PARA GUARDAR 
    function crearProveedor(data) {
        // Simular delay de red
        cargando(false, "Cargando...", null);
        
        setTimeout(() => {
            const nuevoProveedor = {
                id: Date.now().toString(),
                ...data,
                created_at: new Date().toISOString(),
                updated_at: new Date().toISOString()
            };
            console.log(nuevoProveedor);
            
            proveedores.unshift(nuevoProveedor); // insertar al array por el inicio
            cargarProveedores();
            resetForm();
            cargando(true, "Proveedor creado exitosamente.", "success");
        }, 500);
        
        console.log(proveedores);
    }

    function resetForm() {
        const form = document.getElementById('provider-form');
        if (form) {
            form.reset();
        }
        limpiarTodosErrores();
    }

    // CARGAR PROVEEDOR AL HTML
    function cargarProveedores() {
        const filtradoProveedor = filtrarProveedores();
        const contenedor = document.getElementById('providers-list');
        const estadoVacio = document.getElementById('empty-state');
        const noResult = document.getElementById('no-results');
        const providerCount = document.getElementById('provider-count');
        
        // Actualizar contador
        if (providerCount) {
            providerCount.textContent = proveedores.length;
        }
        
        // Limpiar contenedor
        if (contenedor) {
            contenedor.innerHTML = '';
        }
        
        if (proveedores.length === 0) {
            if (estadoVacio) estadoVacio.style.display = 'block';
            if (noResult) noResult.style.display = 'none';
            return;
        }
        
        if (filtradoProveedor.length === 0 && consultaBusquedad) {
            if (estadoVacio) estadoVacio.style.display = 'none';
            if (noResult) noResult.style.display = 'block';
            return;
        }
        
        if (estadoVacio) estadoVacio.style.display = 'none';
        if (noResult) noResult.style.display = 'none';
        
        // Renderizar proveedores
        filtradoProveedor.forEach(provider => {
            const providerCard = crearProveedorCard(provider);
            if (contenedor) {
                contenedor.appendChild(providerCard);
            }
        });
    }

    function filtrarProveedores() {
        if (!consultaBusquedad) {
            return proveedores;
        }
        
        return proveedores.filter(provider =>
            provider.name.toLowerCase().includes(consultaBusquedad) ||
            provider.company.toLowerCase().includes(consultaBusquedad) ||
            provider.email.toLowerCase().includes(consultaBusquedad) ||
            provider.category.toLowerCase().includes(consultaBusquedad)
        );
    }

    function crearProveedorCard(proveedor) {
        const statusClass = proveedor.status === 'active' ? 'status-active' : 'status-inactive';
        const statusIcon = proveedor.status === 'active' ? 'fas fa-check-circle' : 'fas fa-times-circle';
        const statusText = proveedor.status === 'active' ? 'Activo' : 'Inactivo';
        
        const createdDate = formatDate(proveedor.created_at);
        const updatedDate = formatDate(proveedor.updated_at);
        const showUpdated = proveedor.updated_at !== proveedor.created_at;
        
        const cardDiv = document.createElement('div');
        cardDiv.className = 'provider-card';
        cardDiv.setAttribute('data-id', proveedor.id);
        
        cardDiv.innerHTML = `
            <div class="provider-header">
                <div class="provider-title">
                    <h3>${proveedor.name}</h3>
                    <span class="status-badge-small ${statusClass}">
                        <i class="${statusIcon}"></i>
                        ${statusText}
                    </span>
                </div>
                <div class="provider-actions">
                    <button class="btn-edit" onclick="editProveedorById('${proveedor.id}')" title="Editar proveedor">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-delete ${eliminarConfirm === proveedor.id ? 'confirm' : ''}" 
                            onclick="eliminarProveedorById('${proveedor.id}')" 
                            title="${eliminarConfirm === proveedor.id ? 'Confirmar eliminación' : 'Eliminar proveedor'}">
                        <i class="fas ${eliminarConfirm === proveedor.id ? 'fa-exclamation-triangle' : 'fa-trash'}"></i>
                    </button>
                </div>
            </div>
            
            <div class="provider-info">
                <div class="provider-info-item">
                    <i class="fas fa-building"></i>
                    <span>${proveedor.company}</span>
                </div>
                <div class="provider-info-item">
                    <i class="fas fa-envelope"></i>
                    <a href="mailto:${proveedor.email}">${proveedor.email}</a>
                </div>
                <div class="provider-info-item">
                    <i class="fas fa-phone"></i>
                    <a href="tel:${proveedor.phone}">${proveedor.phone}</a>
                </div>
                <div class="provider-info-item">
                    <i class="fas fa-tag"></i>
                    <span class="category-tag">${proveedor.category}</span>
                </div>
            </div>
            
            <div class="provider-address">
                <i class="fas fa-map-marker-alt"></i>
                <span>${proveedor.address}</span>
            </div>
            
            <div class="provider-dates">
                Creado: ${createdDate}
                ${showUpdated ? ` • Actualizado: ${updatedDate}` : ''}
            </div>
            
            ${eliminarConfirm === proveedor.id ? `
                <div class="delete-confirm">
                    <i class="fas fa-exclamation-triangle"></i>
                    ¿Estás seguro? Haz clic nuevamente para confirmar la eliminación.
                </div>
            ` : ''}
        `;
        
        return cardDiv;
    }

    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('es-ES', {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    }

    function escapeHtml(text) {
       /* const div = document.createElement('div');
        div.textContent = text;
        console.log(div.innerHTML)
        return div.innerHTML;*/
    }

    // METODO PARA EDITAR 
    // utilizamos window ya que estamos utilizando onclick del DOM
    window.editProveedorById = function(id) {
        const provider = proveedores.find(p => p.id === id);
        if (provider) {
            editarProveedorForm(provider);
        }
    };

    function editarProveedorForm(provider) {
        editarProveedor = provider;
        
        // Llenar el formulario
        setValue('name', provider.name);
        setValue('email', provider.email);
        setValue('phone', provider.phone);
        setValue('company', provider.company);
        setValue('address', provider.address);
        setValue('category', provider.category);
        setValue('status', provider.status);
        
        // Cambiar UI del formulario
        const formTitle = document.getElementById('form-title');
        const submitBtn = document.getElementById('submit-btn');
        const cancelButtons = document.querySelectorAll('#cancel-edit, #cancel-btn');
        
        if (formTitle) {
            formTitle.innerHTML = '<i class="fas fa-save"></i> Editar Proveedor';
        }
        if (submitBtn) {
            submitBtn.innerHTML = '<i class="fas fa-save"></i> <span>Actualizar Proveedor</span>';
        }
        
        cancelButtons.forEach(btn => {
            btn.style.display = 'block';
        });
        
        // Scroll al formulario
        const formSection = document.querySelector('.form-section');
        if (formSection) {
            formSection.scrollIntoView({ behavior: 'smooth' });
        }
    }

    function setValue(id, value) {
        const element = document.getElementById(id);
        if (element) {
            element.value = value;
        }
    }

    function actulizarProveedor(data) {
        cargando(false, "Editando...", null);
        
        setTimeout(() => {
            const index = proveedores.findIndex(p => p.id === editarProveedor.id);
            if (index !== -1) {
                proveedores[index] = {
                    ...proveedores[index],
                    ...data,
                    updated_at: new Date().toISOString()
                };
                cargarProveedores();
                cancelEdit();
            }
            cargando(true, 'Proveedor actualizado exitosamente', 'success');
        }, 400);
    }

    // CANCELAR LA ACTUALIZAR DEL FORMULARIO
    function cancelEdit() {
        editarProveedor = null;
        resetForm();
        
        // Restaurar UI del formulario
        const formTitle = document.getElementById('form-title');
        const submitBtn = document.getElementById('submit-btn');
        const cancelButtons = document.querySelectorAll('#cancel-edit, #cancel-btn');
        
        if (formTitle) {
            formTitle.innerHTML = '<i class="fas fa-plus"></i> Nuevo Proveedor';
        }
        if (submitBtn) {
            submitBtn.innerHTML = '<i class="fas fa-plus"></i> <span>Crear Proveedor</span>';
        }
        
        cancelButtons.forEach(btn => {
            btn.style.display = 'none';
        });
    }

    // METODO PARA ELIMINAR UN REGISTRO
    window.eliminarProveedorById = function(id) {
        if (eliminarConfirm === id) {
            eliminarProveedor(id);
            eliminarConfirm = null;
        } else {
            eliminarConfirm = id;
            cargarProveedores();
            
            // Auto-cancel delete confirmation after 3 seconds
            setTimeout(() => {
                if (eliminarConfirm === id) {
                    eliminarConfirm = null;
                    cargarProveedores();
                }
            }, 3000);
        }
    };

    function eliminarProveedor(id) {
        cargando(false, "eliminando proveedor...", null);
        
        setTimeout(() => {
            // Crea un nuevo array que excluye al proveedor con ese id.
            proveedores = proveedores.filter(p => p.id !== id);
            cargarProveedores();
            cargando(true, 'Proveedor eliminado exitosamente', 'success');
        }, 300);
    }

    function cargando(estado, title, icon) {
        // Asumiendo que SweetAlert2 sigue disponible
        if (typeof Swal !== 'undefined') {
            Swal.fire({
                position: "center",
                icon: icon,
                title: title,
                showConfirmButton: estado,
                timer: estado ? 0 : 1500
            });
        } else {
            // Fallback simple si SweetAlert2 no está disponible
            console.log(`${icon}: ${title}`);
        }
    }
});